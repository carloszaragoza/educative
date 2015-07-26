
package us.educative.config
{
	[Bindable]
	public class EducativeConstants
	{
		
		/**
		 * Todas las constantes relacionadas con los servicios 
		 */
		//public static var SERVICE_END_POINT:String = "http://127.0.0.1/amfphp/Amfphp/";
		//Production
		public static var REPORTE:String = "/amfphp/Amfphp/Services/reporte.php";
		public static var SERVICE_END_POINT:String = "/amfphp/Amfphp/";
		public static var SERVICE_DESTINATION_LOGIN:String   = "LoginBusiness";
		public static var SERVICE_SOURCE_LOGIN:String   = "LoginBusiness";
		public static var SERVICE_DESTINATION_AND_SOURCE_ALUMNO:String = "Alumno";
		public static var SERVICE_PADRES:String = "Padres";
		public static var SERVICE_DIRECCION:String ="Direccion";
		public static var SERVICE_PERFIL:String ="Perfil";
		public static var SERVICE_EMPLEADO:String = "Empleado";
		public static var SERVICE_PERIODO:String = "Periodo";
		public static var SERVICE_NIVEL_EDUCATIVO:String = "NivelEducativo";
		public static var SERVICE_CONTROL_INSCRIPCION:String = "ControlInscripcion";
        public static var SERVICE_SERVICIOS_PRODUCTOS:String = "ServiciosProductos";
        public static var SERVICE_INGRESOS:String = "Ingresos";
		public static var SERVICE_PLAN_DE_PAGOS:String = "PlanDePagos";
		public static var SERVICE_DASHBOARD:String = "Dashboard";

        public static const RECARGO_POR_MORA:Number = 200.00;
        public static const PORCENTAJE_RECARGO_FIJO:int = 10;
        public static const ESTADO_DE_CUENTA:String = "/reportes/estadoDeCuenta.php";
		public static const DEUDORES_POR_MES:String = "/reportes/deudoresPorMes.php";
		public static const PAGOS_POR_MES:String = "/reportes/pagosPorMes.php";
        
		
		public function EducativeConstants()
		{
		}
	}
}