import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/catalogs/add_edit_video/cubit/cubit.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoFormCubit, VideoFormState>(
      listenWhen: (p, c) => p.status != c.status || p.video != c.video,
      listener: (context, state) {
        if (state.status == VideoFormStatus.success && state.video != null) {
          Navigator.of(context).pop();
        } else if (state.video != null) {
          _populate(state.video!);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<VideoFormCubit, VideoFormState>(
            buildWhen: (p, c) => p.video?.id != c.video?.id,
            builder: (_, s) =>
                Text(s.video == null ? 'Add Video' : 'Edit Video'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<VideoFormCubit, VideoFormState>(
            buildWhen: (p, c) => p.status != c.status,
            builder: (context, state) {
              if (state.status == VideoFormStatus.loading &&
                  state.video == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
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
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _thumbCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Thumbnail URL',
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<CatalogType>(
                      value: _type,
                      items: CatalogType.values
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _type = v!),
                      decoration: const InputDecoration(labelText: 'Type'),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<VideoFormCubit, VideoFormState>(
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
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
