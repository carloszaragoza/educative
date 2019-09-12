package us.educative.events
{
	import flash.events.Event;
	
	import us.educative.VO.UsuarioDTO;
	
	public class CommonEvent extends Event
	{
		public static const USER_TRY_LOGIN_EVENT:String = "userTryLoginEvent";
		public static const USER_LOGGED_EVENT:String = "userLoggedEvent";
		public static const DASHBOARD_GET_CHARTS:String = "dashboardGetCharts";
		public static const PERIOD_ACTIVE_EVENT:String = "periodActiveEvent";
		public static const MENU_SELECCIONA_COMPONENTE:String = "menuSeleccionaComponente";
		
		public var usuario:UsuarioDTO;
		
		public var item:Object;
		
		public function CommonEvent(type:String)
		{
			super(type, true);
		}
	}
}
