package us.educative.VO
{
	[Bindable]
	//[RemoteClass(alias="services.UsuarioModel")]
	public class UsuarioDTO
	{
		public var id_usuario:int;
		public var empleado_id:int;
		public var nivel_educativo_id:int;
		public var privilegio:int;
		public var usuario:String;
		public var clave_acceso:String;
		public var contador_firmas:int;
		public var desde_donde_se_firma:String;
		public var fue_creado:Date;
		public function UsuarioDTO()
		{
			
		}
	}
}