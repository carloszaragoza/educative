package us.educative.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.VO.PeriodoVO;
	import us.educative.config.EducativeConstants;

	public class PeriodoService
	{
		private var periodoRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_PERIODO);
		public function PeriodoService()
		{
			periodoRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			periodoRO.source = EducativeConstants.SERVICE_PERIODO;
				
		}
		
		public function save(periodo:PeriodoVO):AsyncToken
		{
			return periodoRO.save(periodo.tipo_periodo, periodo.nombre, periodo.fecha_inicial, periodo.fecha_final);
		}
		
		public function getAll():AsyncToken
		{
			return periodoRO.getAll();
		}
		public function getAllByFilter(busqueda:String):AsyncToken
		{
			return periodoRO.getAllByFilter(busqueda);
		}
		public function update(periodo:PeriodoVO):AsyncToken
		{
			return periodoRO.update(periodo.tipo_periodo, periodo.nombre, periodo.fecha_inicial, periodo.fecha_final, periodo.id_periodo);
		}
		
		public function deleteRecord(data:Object):AsyncToken
		{
			return periodoRO.deleteRecord(data.id_periodo);
		}
	}
}