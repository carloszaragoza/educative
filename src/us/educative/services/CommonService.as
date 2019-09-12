package us.educative.services
{
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;

import org.swizframework.utils.async.AsyncTokenOperation;

import us.educative.VO.UsuarioDTO;
	import us.educative.config.EducativeConstants;

	public class CommonService
	{
		//Declaraión del objeto remoto para el Login servicio
		private var loginRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_DESTINATION_LOGIN);
		private var padreRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_PADRES);
		private var perfilRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_PERFIL);
		private var dashboardRO:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_DASHBOARD);
		
		//Constructor para generar el Objeto Remoto
		public function CommonService()
		{
			loginRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			loginRO.source = EducativeConstants.SERVICE_SOURCE_LOGIN;
			//loginRO.destination  ="amfphp";
			loginRO.showBusyCursor = true;
			
			padreRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			padreRO.source = EducativeConstants.SERVICE_PADRES;
			padreRO.destination = "Padres";
			
			perfilRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			perfilRO.source = EducativeConstants.SERVICE_PERFIL;
			
			dashboardRO.endpoint = EducativeConstants.SERVICE_END_POINT;
			dashboardRO.source = EducativeConstants.SERVICE_DASHBOARD;
			
		}
		public function getPeriodo():AsyncToken
		{
			return dashboardRO.getPeriodo();
		}
		
		//Lee al usaurio y lo valida con el servicio en PHP 
		public function userLogin(usuario:UsuarioDTO):AsyncToken
		{
			return loginRO.checkCredentials(usuario.usuario, usuario.clave_acceso);
		}
		public function getAllPadres():AsyncToken
		{
			return padreRO.getAll();
		}
		public function getAllPerfiles():AsyncToken
		{
			return perfilRO.getAll();
		}
		public function getAlumnosSexoGrafica():AsyncToken
		{
			return dashboardRO.getAlumnosSexo();
		}
		
		public function getNivelAlumnos():mx.rpc.AsyncToken
		{
			// TODO Auto Generated method stub
			return dashboardRO.getNivelAlumnos();
		}
		
		public function getIngresos():mx.rpc.AsyncToken
		{
			// TODO Auto Generated method stub
			return dashboardRO.getIngresos();
		}
		
		public function getPorCobrar():mx.rpc.AsyncToken
		{
			// TODO Auto Generated method stub
			return dashboardRO.getPorCobrar();
		}
	}
}
