package us.educative.VO
{
	[RemoteClass(alias="EmpleadoModel")]
	[Bindable]
	public class EmpleadoVO
	{
		public var id_empleado:int;
		public var rfc_empleado:String;
		public var nombre:String;
		public var paterno:String;
		public var materno:String;
		public var fecha_nacimiento:String;
		public var fecha_alta:Date;
		public var direccion:String;
		public var telefono_fijo:String;
		public var celular:String;
		public var correo:String;
		public var perfil_id:int;
		public var horas_semana:int;
		public var grado_maximo_estudio:String;
		public var NSS:String;
		public var observaciones:String;
		public var cp:String;
		
		public function EmpleadoVO()
		{
		}
	}
}