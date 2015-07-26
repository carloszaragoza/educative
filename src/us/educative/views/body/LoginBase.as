package us.educative.views.body
{
	import spark.components.Group;
	
	import us.educative.events.CommonEvent;
	import us.educative.VO.UsuarioDTO;
	
	public class LoginBase extends Group
	{
		private var view:Login = Login(this);
		public function LoginBase()
		{
			super();
		}
		
		
		protected function clicLogin():void
		{
			var usuario:UsuarioDTO = new UsuarioDTO();
			usuario.usuario = view.txtUsuario.text;
			usuario.clave_acceso = view.txtClave.text;
			
			var userLoginEvent:CommonEvent = new CommonEvent(CommonEvent.USER_TRY_LOGIN_EVENT);
			userLoginEvent.usuario = usuario;
			this.dispatchEvent(userLoginEvent);
		}
		
	}
}