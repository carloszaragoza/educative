package us.educative.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.config.EducativeConstants;

	public class PlanDePagosService
	{
		private var planRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_PLAN_DE_PAGOS);
		public function PlanDePagosService()
		{
			planRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			planRO.source = EducativeConstants.SERVICE_PLAN_DE_PAGOS;
		}
		
		
		public function getAllAlumnos():AsyncToken
		{
			// TODO Auto Generated method stub
			return planRO.getAllAlumnos();
		}
		
		public function getAllPlanes():AsyncToken
		{
			// TODO Auto Generated method stub
			return planRO.getAllPlanes();
		}
		
		public function buscaConceptosPorAlumno(alumno:Object):AsyncToken
		{
			// TODO Auto Generated method stub
			return planRO.buscaConceptosPorAlumno(alumno.id_alumno, alumno.id_control_inscripcion);
		}
		
		public function borrarConcepto(id_registro_pago:int):AsyncToken
		{
			// TODO Auto Generated method stub
			return planRO.borrarConcepto(id_registro_pago);
		}
		
		public function getAllProductoServicio(busqueda:Object):AsyncToken
		{
			// TODO Auto Generated method stub
			return planRO.getAllProductoServicio(busqueda);
		}
		
		public function agregarConcepto(concepto:Object):AsyncToken
		{
			return planRO.agregarConcepto(concepto);
		}
		
		public function aplicaPlan(objeto:Object):AsyncToken
		{
			// TODO Auto Generated method stub
			return planRO.aplicaPlan(objeto);
		}
	}
}