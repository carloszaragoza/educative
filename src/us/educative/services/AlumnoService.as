package us.educative.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.VO.AlumnoVO;
	import us.educative.VO.FileVO;
	import us.educative.config.EducativeConstants;

	public class AlumnoService
	{
		private var alumnoRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_DESTINATION_AND_SOURCE_ALUMNO);
		
		public function AlumnoService()
		{
			alumnoRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			alumnoRO.source = EducativeConstants.SERVICE_DESTINATION_AND_SOURCE_ALUMNO;
			alumnoRO.showBusyCursor = true;
		}
		
		public function save(alumno:AlumnoVO):AsyncToken
		{
			return alumnoRO.add(alumno.sexo, alumno.apaterno, alumno.amaterno, alumno.nombre,
			alumno.fecha_nac, alumno.fotografia, alumno.tel_emergencia, alumno.alergias,
			alumno.enf_precauciones, alumno.curp, alumno.correo_electronico, alumno.tipo_sangre,
			alumno.tutor_id, alumno.matricula);
		}
		
		public function getAll(busqueda:String):AsyncToken
		{
			return alumnoRO.getAll(busqueda);
		}
		
		public function deleteById(idAlumno:int):AsyncToken
		{
			return alumnoRO.deleteRecord(idAlumno);
		}
		
		public function update(alumno:AlumnoVO):AsyncToken
		{
			return alumnoRO.update(alumno.sexo, alumno.apaterno, alumno.amaterno, alumno.nombre,
				alumno.fecha_nac, alumno.fotografia, alumno.tel_emergencia, alumno.alergias,
				alumno.enf_precauciones, alumno.curp, alumno.correo_electronico, alumno.tipo_sangre,
				alumno.tutor_id, alumno.matricula, alumno.id_alumno);
		}
		
		public function uploadFile(file:FileVO):AsyncToken
		{
			return alumnoRO.uploadServer(file);
		}


    }
}