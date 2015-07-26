package us.educative.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.config.EducativeConstants;

	public class NivelEducativoService
	{
		private var nivelRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_NIVEL_EDUCATIVO);
		
		public function NivelEducativoService()
		{
			nivelRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			nivelRO.source = EducativeConstants.SERVICE_NIVEL_EDUCATIVO;
			nivelRO.showBusyCursor = true;
		}
		
		public function getAll():AsyncToken
		{
			return nivelRO.getAll();
		}
	}
}