package us.educative.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.VO.EmpleadoVO;
	import us.educative.config.EducativeConstants;

	public class EmpleadoService
	{
		private var empleadoRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_EMPLEADO);
		
		public function EmpleadoService()
		{
			empleadoRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			empleadoRO.source = EducativeConstants.SERVICE_EMPLEADO;
			empleadoRO.showBusyCursor = true;
		}
		
		public function getAll():AsyncToken
		{
			return empleadoRO.getAll();
		}
		public function getAllByFilter(busqueda:String):AsyncToken
		{
			return empleadoRO.getAllByFilter(busqueda);
		}
		
		public function save(empleado:EmpleadoVO):AsyncToken
		{
			return empleadoRO.add(empleado.rfc_empleado, empleado.nombre, empleado.paterno,
			empleado.materno, empleado.fecha_nacimiento, empleado.direccion, empleado.cp,
			empleado.celular, empleado.telefono_fijo, empleado.correo, empleado.perfil_id,
			empleado.grado_maximo_estudio, empleado.horas_semana, empleado.observaciones, empleado.NSS);
		}
		
		public function deleteRecord(objeto:Object):AsyncToken
		{
			return empleadoRO.deleteRecord(objeto.id_empleado);
		}
		
		public function update(empleado:EmpleadoVO):AsyncToken
		{
			return empleadoRO.update(empleado.rfc_empleado, empleado.nombre, empleado.paterno,
				empleado.materno, empleado.fecha_nacimiento, empleado.direccion, empleado.cp,
				empleado.celular, empleado.telefono_fijo, empleado.correo, empleado.perfil_id,
				empleado.grado_maximo_estudio, empleado.horas_semana, empleado.observaciones, empleado.NSS, empleado.id_empleado)
		}
		
		public function getAllProfesors():AsyncToken
		{
			return empleadoRO.getAllProfesors();
		}
	}
}