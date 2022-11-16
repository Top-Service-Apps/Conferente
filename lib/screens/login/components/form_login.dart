import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sizer/sizer.dart';

class FormLoginComponent extends StatefulWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController nomeController;
  final TextEditingController senhaController;
  const FormLoginComponent({
    Key? key,
    required this.nomeController,
    required this.senhaController,
    required this.keyForm,
  }) : super(key: key);

  @override
  State<FormLoginComponent> createState() => _FormLoginComponentState();
}

class _FormLoginComponentState extends State<FormLoginComponent> {
  bool _vizualizarSenha = false;

  void _ocultarSenha() {
    setState(() {
      _vizualizarSenha = !_vizualizarSenha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.keyForm,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            controller: widget.nomeController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Nome",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Digite o nome do usuário";
              } else if (value.length < 4) {
                return "Nome curto, minímo de 4 letras";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 3.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: widget.senhaController,
            obscureText: _vizualizarSenha,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                onPressed: () {
                  _ocultarSenha();
                },
                icon: _vizualizarSenha
                    ? const Icon(
                        Ionicons.eye_off,
                      )
                    : const Icon(
                        Ionicons.eye,
                      ),
              ),
              labelText: "Senha",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Digite uma senha válida";
              } else if (value.length < 6) {
                return "Senha curta, minímo de 6 digitos";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }
}
