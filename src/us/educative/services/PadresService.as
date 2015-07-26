package us.educative.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.VO.FamiliaVO;
	import us.educative.config.EducativeConstants;

	public class PadresService
	{
		private var padresRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_PADRES);
		
		public function PadresService()
		{
			padresRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			padresRO.source = EducativeConstants.SERVICE_PADRES;
			padresRO.showBusyCursor = true;
		}
		public function save(familia:FamiliaVO):AsyncToken
		{
			return padresRO.save(familia.p_nombre, familia.p_paterno, familia.p_materno, familia.p_telefono, familia.p_correo,
				familia.m_nombre, familia.m_paterno, familia.m_materno, familia.m_telefono, familia.m_correo,
				familia.direccion, familia.localidad_id, familia.municipio_id, familia.entidad_id, familia.cp, familia.familia);
		}
		public function getAllByFilter(busqueda:String):AsyncToken
		{
			return padresRO.getAllByFilter(busqueda);
		}
		
		public function deletePadre(id_tutor:int):AsyncToken
		{
			return padresRO.deletePadre(id_tutor);
		}
		public function updatePadre(familia:FamiliaVO):AsyncToken
		{
			return padresRO.update(familia.p_nombre, familia.p_paterno, familia.p_materno, familia.p_telefono, familia.p_correo,
				familia.m_nombre, familia.m_paterno, familia.m_materno, familia.m_telefono, familia.m_correo,
				familia.direccion, familia.localidad_id, familia.municipio_id, familia.entidad_id, familia.cp, familia.familia, familia.id_tutor);
		}
	}
}