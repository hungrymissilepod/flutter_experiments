import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/sparkle_party_demo/particlefx/particle_fx.dart';
import 'package:flutter_app_template/utils/sprite_sheet.dart';

class FXEntry {
  ParticleFX Function({required SpriteSheet spriteSheet, required Size size})
      create;
  String name;
  ImageProvider? icon;

  FXEntry(this.name, {required this.create, this.icon});
}
