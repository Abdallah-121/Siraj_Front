import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seraj/features/teachers/domain/entites/promotion_user_entity.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gap.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/teacher_promotion_cubit.dart';
import '../cubit/teacher_promotion_state.dart';

class PromoteTeacherDialog extends StatefulWidget {
  final int mosqueId;

  const PromoteTeacherDialog({super.key, required this.mosqueId});

  @override
  State<PromoteTeacherDialog> createState() => _PromoteTeacherDialogState();
}

class _PromoteTeacherDialogState extends State<PromoteTeacherDialog> {
  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();

    _searchController.dispose();
    _qualificationController.dispose();
    _bioController.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      context.read<TeacherPromotionCubit>().searchUsers(value);
    });
  }

  void _onPromotePressed() {
    final qualification = _qualificationController.text.trim();
    final bio = _bioController.text.trim();

    if (qualification.isEmpty || bio.isEmpty) {
      _showRequiredFieldsMessage();
      return;
    }

    context.read<TeacherPromotionCubit>().promoteSelectedUser(
      mosqueId: widget.mosqueId,
      qualification: qualification,
      bio: bio,
    );
  }

  void _onCreateTeacherPressed() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final qualification = _qualificationController.text.trim();
    final bio = _bioController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        qualification.isEmpty ||
        bio.isEmpty) {
      _showRequiredFieldsMessage();
      return;
    }

    context.read<TeacherPromotionCubit>().createTeacher(
      mosqueId: widget.mosqueId,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      qualification: qualification,
      bio: bio,
    );
  }

  void _showRequiredFieldsMessage() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.l10n.pleaseFillRequiredFields)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherPromotionCubit, TeacherPromotionState>(
      listenWhen: (previous, current) {
        return previous.errorMessage != current.errorMessage ||
            previous.isSuccess != current.isSuccess;
      },
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        if (state.isSuccess) {
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SingleChildScrollView(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: state.mode == TeacherPromotionMode.search
                      ? _SearchAndPromoteContent(
                          key: const ValueKey('search'),
                          state: state,
                          searchController: _searchController,
                          qualificationController: _qualificationController,
                          bioController: _bioController,
                          onSearchChanged: _onSearchChanged,
                          onPromotePressed: _onPromotePressed,
                          onCreateTeacherPressed: () {
                            context
                                .read<TeacherPromotionCubit>()
                                .showCreateTeacherForm();
                          },
                        )
                      : _CreateTeacherContent(
                          key: const ValueKey('create'),
                          state: state,
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          qualificationController: _qualificationController,
                          bioController: _bioController,
                          onBackPressed: () {
                            context
                                .read<TeacherPromotionCubit>()
                                .showSearchForm();
                          },
                          onCreatePressed: _onCreateTeacherPressed,
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SearchAndPromoteContent extends StatelessWidget {
  final TeacherPromotionState state;
  final TextEditingController searchController;
  final TextEditingController qualificationController;
  final TextEditingController bioController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onPromotePressed;
  final VoidCallback onCreateTeacherPressed;

  const _SearchAndPromoteContent({
    super.key,
    required this.state,
    required this.searchController,
    required this.qualificationController,
    required this.bioController,
    required this.onSearchChanged,
    required this.onPromotePressed,
    required this.onCreateTeacherPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool noResults =
        state.hasSearched && !state.isSearching && state.users.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DialogHeader(
          title: context.l10n.promoteUserToTeacher,
          subtitle: context.l10n.promoteUserToTeacherHint,
        ),
        AppGap.v20,
        AppTextField(
          controller: searchController,
          hintText: context.l10n.searchUserForPromotionHint,
          prefixIcon: const Icon(Icons.search_rounded),
          onChanged: onSearchChanged,
        ),
        AppGap.v16,
        if (state.isSearching)
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (state.users.isNotEmpty)
          _UsersResultList(users: state.users, selectedUser: state.selectedUser)
        else if (noResults)
          _NoUsersFoundCard(onCreateTeacherPressed: onCreateTeacherPressed)
        else
          _SearchHelpCard(text: context.l10n.searchUserForPromotionStart),
        if (state.selectedUser != null) ...[
          AppGap.v20,
          _TeacherInfoFields(
            qualificationController: qualificationController,
            bioController: bioController,
          ),
          AppGap.v20,
          AppButton(
            label: context.l10n.promoteToTeacher,
            isLoading: state.isSubmitting,
            onPressed: onPromotePressed,
          ),
        ],
      ],
    );
  }
}

class _CreateTeacherContent extends StatelessWidget {
  final TeacherPromotionState state;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController qualificationController;
  final TextEditingController bioController;
  final VoidCallback onBackPressed;
  final VoidCallback onCreatePressed;

  const _CreateTeacherContent({
    super.key,
    required this.state,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.qualificationController,
    required this.bioController,
    required this.onBackPressed,
    required this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: state.isSubmitting ? null : onBackPressed,
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            Expanded(
              child: _DialogHeader(
                title: context.l10n.createTeacherAccount,
                subtitle: context.l10n.createTeacherAccountHint,
              ),
            ),
          ],
        ),
        AppGap.v20,
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: firstNameController,
                hintText: context.l10n.enterFirstName,
                label: context.l10n.firstName,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                controller: lastNameController,
                hintText: context.l10n.enterLastName,
                label: context.l10n.lastName,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
            ),
          ],
        ),
        AppGap.v16,
        AppTextField(
          controller: emailController,
          hintText: context.l10n.enterEmail,
          label: context.l10n.email,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        AppGap.v16,
        AppTextField(
          controller: passwordController,
          hintText: context.l10n.enterPassword,
          label: context.l10n.password,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
        ),
        AppGap.v16,
        _TeacherInfoFields(
          qualificationController: qualificationController,
          bioController: bioController,
        ),
        AppGap.v20,
        AppButton(
          label: context.l10n.createTeacherAccount,
          isLoading: state.isSubmitting,
          onPressed: onCreatePressed,
        ),
      ],
    );
  }
}

class _DialogHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _DialogHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _UsersResultList extends StatelessWidget {
  final List<PromotionUserEntity> users;
  final PromotionUserEntity? selectedUser;

  const _UsersResultList({required this.users, required this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: users
          .map(
            (user) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _UserResultTile(
                user: user,
                isSelected: selectedUser?.userId == user.userId,
                onTap: () {
                  context.read<TeacherPromotionCubit>().selectUser(user);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

class _UserResultTile extends StatelessWidget {
  final PromotionUserEntity user;
  final bool isSelected;
  final VoidCallback onTap;

  const _UserResultTile({
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColors.primary.withValues(alpha: 0.08)
          : AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.10),
                child: Text(
                  user.fullName.trim().isEmpty
                      ? '?'
                      : user.fullName.trim().characters.first,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (user.phone.trim().isNotEmpty)
                      Text(
                        user.phone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoUsersFoundCard extends StatelessWidget {
  final VoidCallback onCreateTeacherPressed;

  const _NoUsersFoundCard({required this.onCreateTeacherPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.16)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.person_add_alt_1_rounded,
            color: AppColors.primary,
            size: 34,
          ),
          AppGap.v12,
          Text(
            context.l10n.noUsersFoundForPromotion,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          AppGap.v12,
          AppButton(
            label: context.l10n.createTeacherAccount,
            onPressed: onCreateTeacherPressed,
          ),
        ],
      ),
    );
  }
}

class _SearchHelpCard extends StatelessWidget {
  final String text;

  const _SearchHelpCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeacherInfoFields extends StatelessWidget {
  final TextEditingController qualificationController;
  final TextEditingController bioController;

  const _TeacherInfoFields({
    required this.qualificationController,
    required this.bioController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: qualificationController,
          label: context.l10n.qualification,
          hintText: context.l10n.enterTeacherQualification,
          prefixIcon: const Icon(Icons.school_outlined),
        ),
        AppGap.v16,
        AppTextField(
          controller: bioController,
          label: context.l10n.bio,
          hintText: context.l10n.enterTeacherBio,
          maxLines: 4,
          prefixIcon: const Icon(Icons.notes_outlined),
        ),
      ],
    );
  }
}
