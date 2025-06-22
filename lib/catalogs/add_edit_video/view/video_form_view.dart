// ignore_for_file: lines_longer_than_80_chars, document_ignores, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/catalogs/add_edit_video/cubit/cubit.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';
import 'package:uponorflix/widgets/app_drawer.dart';

class VideoFormView extends StatefulWidget {
  const VideoFormView({super.key});
  @override
  State<VideoFormView> createState() => _VideoFormViewState();
}

class _VideoFormViewState extends State<VideoFormView> {
  final _titleCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _thumbCtrl = TextEditingController();
  CatalogType _type = CatalogType.movie;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _yearCtrl.dispose();
    _thumbCtrl.dispose();
    super.dispose();
  }

  void _populate(VideoViewModel v) {
    _titleCtrl.text = v.title;
    _yearCtrl.text = v.year.toString();
    _thumbCtrl.text = v.thumbnailUrl;
    _type = v.type;
  }

  VideoViewModel _gather() => VideoViewModel(
    id: context.read<VideoFormCubit>().state.video?.id ?? '',
    title: _titleCtrl.text.trim(),
    year: int.parse(_yearCtrl.text.trim()),
    thumbnailUrl: _thumbCtrl.text.trim(),
    type: _type,
  );

  Future<void> _confirmDelete(BuildContext context) async {
    final ok =
        await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete video'),
            content: const Text(
              'Are you sure you want to delete this video? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
    if (ok == true && mounted) {
      await context.read<VideoFormCubit>().delete();
      context.replace('/catalog');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoFormCubit, VideoFormState>(
      listenWhen: (p, c) => p.status != c.status || p.video != c.video,
      listener: (context, state) {
        if (state.status == VideoFormStatus.success) {
          context.replace('/catalog');
        } else if (state.video != null) {
          _populate(state.video!);
        }
      },
      builder: (BuildContext context, VideoFormState state) {
        if (!state.loadData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(
              title: BlocBuilder<VideoFormCubit, VideoFormState>(
                buildWhen: (p, c) => p.video?.id != c.video?.id,
                builder: (_, s) =>
                    Text(s.video == null ? 'Add Video' : 'Edit Video'),
              ),
              actions: [
                BlocBuilder<VideoFormCubit, VideoFormState>(
                  buildWhen: (p, c) => p.video?.id != c.video?.id,
                  builder: (_, s) {
                    if (s.video == null) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _confirmDelete(context),
                    );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: AdaptiveLayout(
                  body: SlotLayout(
                    config: <Breakpoint, SlotLayoutConfig>{
                      Breakpoints.small: SlotLayout.from(
                        key: const Key('top small'),
                        builder: (_) => ListView(
                          children: [
                            TitleInputField(titleCtrl: _titleCtrl),
                            const SizedBox(height: 12),
                            YearInputField(yearCtrl: _yearCtrl),
                            const SizedBox(height: 12),
                            ThumbnailInputField(thumbCtrl: _thumbCtrl),
                            const SizedBox(height: 12),
                            _Preview(thumbCtrl: _thumbCtrl),
                            const SizedBox(height: 12),
                            newMethod(),
                            const SizedBox(height: 24),
                            saveEditButton(),
                          ],
                        ),
                      ),
                      Breakpoints.mediumAndUp: SlotLayout.from(
                        key: const Key('top mediumAndUp'),
                        builder: (_) => Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ListView(
                                  children: [
                                    TitleInputField(titleCtrl: _titleCtrl),
                                    const SizedBox(height: 12),
                                    YearInputField(yearCtrl: _yearCtrl),
                                    const SizedBox(height: 12),
                                    ThumbnailInputField(thumbCtrl: _thumbCtrl),
                                    const SizedBox(height: 12),
                                    newMethod(),
                                    const SizedBox(height: 24),
                                    saveEditButton(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _Preview(thumbCtrl: _thumbCtrl),
                              ),
                            ],
                          ),
                        ),
                      ),
                    },
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  BlocBuilder<VideoFormCubit, VideoFormState> saveEditButton() {
    return BlocBuilder<VideoFormCubit, VideoFormState>(
      buildWhen: (p, c) => p.video?.id != c.video?.id,
      builder: (context, s) {
        final isEdit = s.video != null;
        return ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            context.read<VideoFormCubit>().save(_gather());
          },
          child: Text(isEdit ? 'Save Changes' : 'Add Video'),
        );
      },
    );
  }

  DropdownButtonFormField<CatalogType> newMethod() {
    return DropdownButtonFormField<CatalogType>(
      value: _type,
      items: CatalogType.values
          .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
          .toList(),
      onChanged: (v) => setState(() => _type = v!),
      decoration: const InputDecoration(labelText: 'Type'),
    );
  }
}

class ThumbnailInputField extends StatefulWidget {
  const ThumbnailInputField({
    required TextEditingController thumbCtrl,
    super.key,
  }) : _thumbCtrl = thumbCtrl;

  final TextEditingController _thumbCtrl;

  @override
  State<ThumbnailInputField> createState() => _ThumbnailInputFieldState();
}

class _ThumbnailInputFieldState extends State<ThumbnailInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._thumbCtrl,
      decoration: const InputDecoration(labelText: 'Thumbnail URL'),
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      onChanged: (value) =>
          context.read<VideoFormCubit>().updateThumbnail(value.trim()),
    );
  }
}

class YearInputField extends StatelessWidget {
  const YearInputField({
    required TextEditingController yearCtrl,
    super.key,
  }) : _yearCtrl = yearCtrl;

  final TextEditingController _yearCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _yearCtrl,
      decoration: const InputDecoration(labelText: 'Year'),
      keyboardType: TextInputType.number,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Required';
        final y = int.tryParse(v);
        if (y == null || y < 1900 || y > DateTime.now().year) {
          return 'Invalid year';
        }
        return null;
      },
    );
  }
}

class TitleInputField extends StatelessWidget {
  const TitleInputField({
    required TextEditingController titleCtrl,
    super.key,
  }) : _titleCtrl = titleCtrl;

  final TextEditingController _titleCtrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _titleCtrl,
      decoration: const InputDecoration(labelText: 'Title'),
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
    );
  }
}

/*───────────── Thumbnail Preview Widget ─────────────*/
class _Preview extends StatelessWidget {
  const _Preview({required this.thumbCtrl});
  final TextEditingController thumbCtrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoFormCubit, VideoFormState>(
      buildWhen: (p, c) => p.thumbnailUrl != c.thumbnailUrl,
      builder: (_, s) {
        final thumb = s.thumbnailUrl?.isNotEmpty ?? false
            ? s.thumbnailUrl!
            : thumbCtrl.text;
        if (thumb.isEmpty) {
          return const Center(child: Text('Preview'));
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(thumb, fit: BoxFit.cover),
        );
      },
    );
  }
}
