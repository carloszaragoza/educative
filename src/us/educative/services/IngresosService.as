/**
 * Created by carlos on 8/13/14.
 */
package us.educative.services {
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.VO.IngresosVO;
	import us.educative.config.EducativeConstants;
	
	public class IngresosService {
		private var ingresosRemote:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_INGRESOS);
		public function IngresosService() {
			ingresosRemote.endpoint = EducativeConstants.SERVICE_END_POINT;
			ingresosRemote.source = EducativeConstants.SERVICE_INGRESOS;
		}
		
		public function getAllGrupos(busqueda:Object):AsyncToken
		{
			return ingresosRemote.getAllGrupos(busqueda.id_periodo, busqueda.id_nivel_educativo);
		}
		
		public function getAllAlumnosService(busqueda:Object):AsyncToken {
			return ingresosRemote.getAllAlumnos(busqueda.id_control_inscripcion);
		}
		
		public function getAllConceptos(id_nivel_educativo:int):AsyncToken {
			return ingresosRemote.getAllConceptos(id_nivel_educativo);
		}
		
		public function savePago(pago:IngresosVO):AsyncToken {
			return ingresosRemote.savePago(pago.id_registro_pago, pago.d_mes_pago, pago.d_monto_de_pago, 
				pago.d_fecha_pago, pago.d_referencia, pago.d_observaciones, pago.d_cuenta_id, pago.m_usuario, 
				pago.d_metodo_pago, pago.d_cant_recargo, pago.m_cantidad_descuento);
		}
		
		public function getAllPagosByAlumno(alumno:Object):AsyncToken
		{
			return ingresosRemote.getAllPagosByAlumno(alumno.id_alumno, alumno.id_control_inscripcion);
		}
		
		public function getAllPagosByAlumnoGeneral(alumno:Object):AsyncToken
		{
			return ingresosRemote.getAllPagosGeneralByAlumno(alumno.id_alumno, alumno.id_control_inscripcion);
		}
		
		public function getAllAlumnosListado():AsyncToken
		{
			// TODO Auto Generated method stub
			return ingresosRemote.getAllAlumnosListado();
		}
		
		public function traeDetalleDePago(objeto:Object):AsyncToken
		{
			// TODO Auto Generated method stub
			return ingresosRemote.getAllPagosDetalle(objeto.id_alumno, objeto.id_producto_servicio, objeto.mes);
		}
		
		public function borrarPago(objeto:Object):AsyncToken
		{
			// TODO Auto Generated method stub
			return ingresosRemote.borrarPago(objeto.id_registro_pago, objeto.numero_pago);
		}
	}
}
