enum Type {Normal, Hybrid, Terrain, Satelite}

class mapTypeGoogle {
  Type type;

  mapTypeGoogle({required this.type});
}

List<mapTypeGoogle> googleMapTypes = [
  mapTypeGoogle(type: Type.Normal),
  mapTypeGoogle(type: Type.Hybrid),
  mapTypeGoogle(type: Type.Terrain),
  mapTypeGoogle(type: Type.Satelite),
];