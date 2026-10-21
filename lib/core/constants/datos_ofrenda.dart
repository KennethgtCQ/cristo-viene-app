/// Datos bancarios para transferencias. Quemados en el código por decisión del
/// cliente; más adelante se leerán desde una URL pública.
class CuentaBancaria {
  const CuentaBancaria({
    required this.banco,
    required this.moneda,
    required this.cuenta,
    required this.cuentaCliente,
    required this.iban,
  });

  final String banco;
  final String moneda;
  final String cuenta;
  final String cuentaCliente;
  final String iban;
}

abstract final class DatosOfrenda {
  static const beneficiario = 'Asociación Cristiana Cristo viene de Cartago';
  static const concepto = 'OFRENDA';

  static const cuentas = <CuentaBancaria>[
    CuentaBancaria(
      banco: 'Banco Nacional de Costa Rica',
      moneda: 'colones',
      cuenta: '100-01-181-000570-9',
      cuentaCliente: '15118110010005707',
      iban: 'CR17015118110010005707',
    ),
    CuentaBancaria(
      banco: 'Banco Nacional de Costa Rica',
      moneda: 'dólares',
      cuenta: '200-02-097-001865-0',
      cuentaCliente: '15109720020018651',
      iban: 'CR31015109720020018651',
    ),
  ];

  static const bancos = ['Promérica', 'BNCR', 'BCR', 'BCT', 'BAC', 'DAVIbank'];
  static const montos = ['₡1.000', '₡2.000', '₡5.000'];
}
