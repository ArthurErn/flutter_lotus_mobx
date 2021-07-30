import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/repository/ordem_servico/image_post.dart';
import 'package:lotus_erp/controllers/galeria_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


var galeria = GaleriaOS();
class ImagensOS extends StatefulWidget {
  const ImagensOS({Key key}) : super(key: key);

  @override
  _ImagensOSState createState() => _ImagensOSState();
}

class _ImagensOSState extends State<ImagensOS> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postImage();
        },
      ),
      appBar: AppBar(
        title: Text("Galeria"),
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.4 - 1,
                  decoration: BoxDecoration(
                      border: Border.all(width: .7, color: Colors.black)),
                  child: Observer(builder: (_) {
                    return Center(
                        child: galeria.image == null
                            ? Text("No images")
                            : Image.file(
                                galeria.image,
                                height: 300,
                              ));
                  })),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  galeria.getImage();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.blue[900]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Adicionar foto",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
