package us.educative.services
{
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.VO.EntidadVO;
	import us.educative.VO.LocalidadVO;
	import us.educative.VO.MunicipioVO;
	import us.educative.config.EducativeConstants;
	
	
	public class DireccionService
	{
		private var direccionRemote:RemoteObject = new RemoteObject("amfphp");
		public function DireccionService()
		{
			direccionRemote.endpoint = EducativeConstants.SERVICE_END_POINT;
			direccionRemote.source = EducativeConstants.SERVICE_DIRECCION;
			direccionRemote.showBusyCursor = true;
		}

		public function catEntidadService():AsyncToken
		{
			return direccionRemote.getAllEntidades();
		}
		public function catMunicipioService(municipio:MunicipioVO):AsyncToken
		{
			return direccionRemote.getAllMunicipios(municipio.idEntidad);
		}
		public function catLocalidadService(localidad:LocalidadVO):AsyncToken
		{
			return direccionRemote.getAllLocalidades(localidad.idEntidad, localidad.idMunicipio);
		}
	}
}