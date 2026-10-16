enum ModoTema { claro, oscuro, sistema }

enum TamanoTexto {
  pequeno(0.9),
  normal(1.0),
  grande(1.15);

  const TamanoTexto(this.factor);
  final double factor;
}

/// Preferencias que viven solo en el dispositivo (shared_preferences).
class PreferenciasLocales {
  const PreferenciasLocales({
    this.tema = ModoTema.sistema,
    this.idioma = 'es',
    this.tamanoTexto = TamanoTexto.normal,
    this.colorAcento,
  });

  final ModoTema tema;
  final String idioma; // 'es' | 'en'
  final TamanoTexto tamanoTexto;
  final int? colorAcento; // ARGB; null = el acento por defecto de cada tema

  PreferenciasLocales copyWith({
    ModoTema? tema,
    String? idioma,
    TamanoTexto? tamanoTexto,
    int? colorAcento,
  }) {
    return PreferenciasLocales(
      tema: tema ?? this.tema,
      idioma: idioma ?? this.idioma,
      tamanoTexto: tamanoTexto ?? this.tamanoTexto,
      colorAcento: colorAcento ?? this.colorAcento,
    );
  }
}
