// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider_shop/models/product.dart';
import 'package:provider_shop/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final imageUrlFocus = FocusNode();

  final imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['price'] = product.price.toStringAsFixed(2);
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    imageUrlFocus.removeListener(updateImage);
    imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  // bool isValidImageURL(String url) {
  //   bool isValidURL = Uri.tryParse(url)?.hasAbsolutePath ?? false;
  //   bool endsWithFile = url.toLowerCase().endsWith('.png') ||
  //       url.toLowerCase().endsWith('.jpg') ||
  //       url.toLowerCase().endsWith('.jpeg');
  //   return isValidURL && endsWithFile;
  // }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductList>(
        context,
        listen: false,
      ).saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Ocorreu um erro!"),
          content: Text("Erro ao salvar o produto"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Ok"),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          title: Text("Formulário de produto"),
          actions: [
            IconButton(
              onPressed: () {
                _submitForm();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Produto salvo com sucesso"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration: InputDecoration(labelText: "Nome"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_priceFocus),
                        onSaved: (name) => _formData['name'] = name ?? '',
                        validator: (_name) {
                          final name = _name ?? '';
                          if (name.trim().isEmpty) {
                            return "Nome é obrigatório";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: InputDecoration(labelText: "Preço"),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocus,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_descriptionFocus),
                        onSaved: (price) =>
                            _formData['price'] = double.parse(price ?? '-1'),
                        validator: (_price) {
                          final priceString = _price ?? '';
                          final price = double.tryParse(priceString) ?? -1;
                          if (price <= 0) {
                            return "Informe um preço válido";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration: InputDecoration(labelText: "Descrição"),
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(imageUrlFocus),
                        onSaved: (description) =>
                            _formData['description'] = description ?? '',
                        validator: (_description) {
                          final description = _description ?? '';

                          if (description.trim().isEmpty) {
                            return "Descrição é obrigatória";
                          }
                          if (description.trim().length < 10) {
                            return "Descrição precisa de no mínimo 10 letras";
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: imageUrlController,
                              decoration:
                                  InputDecoration(labelText: "URL da imagem"),
                              focusNode: imageUrlFocus,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              onFieldSubmitted: (_) => _submitForm(),
                              onSaved: (imageUrl) =>
                                  _formData['imageUrl'] = imageUrl ?? '',
                              validator: (imageUrl) {
                                final imageURL = imageUrl ?? '';
                                if (imageUrl == null) {
                                  return "Informe uma URL";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: imageUrlController.text.isEmpty
                                ? Text("Insira a URL")
                                : Image.network(
                                    imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                            alignment: Alignment.center,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
