/**
 * Created by carlos on 8/11/14.
 */
package us.educative.services {
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import us.educative.VO.ServiciosProductosVO;
	import us.educative.config.EducativeConstants;
	
	public class ServiciosProductosService {
		private var serviciosProductosRemote:RemoteObject = new RemoteObject(EducativeConstants.SERVICE_SERVICIOS_PRODUCTOS);
		public function ServiciosProductosService() {
			serviciosProductosRemote.endpoint = EducativeConstants.SERVICE_END_POINT;
			serviciosProductosRemote.source =  EducativeConstants.SERVICE_SERVICIOS_PRODUCTOS;
		}
		
		public function getByFilter(busquedObjecto:Object):AsyncToken
		{
			return serviciosProductosRemote.getAllByFilter(busquedObjecto.tipo, busquedObjecto.texto);
		}
		
		public function save(sp:ServiciosProductosVO):AsyncToken
		{
			return serviciosProductosRemote.save(sp.tipo_concepto, sp.concepto, sp.periodo_id, sp.nivel_educativo_id,
                    sp.precio_general, sp.precio_publico, sp.aplica_descuento, sp.aplica_recargo, sp.aplica_impuesto, sp.facturable, sp.pago_unico,
                    sp.numero_pagos, sp.observaciones,sp.clave);
		}
		
		public function actualizar(sp:ServiciosProductosVO):AsyncToken
		{
			return serviciosProductosRemote.update(sp.tipo_concepto, sp.concepto, sp.periodo_id, sp.nivel_educativo_id,
				sp.precio_general, sp.precio_publico, sp.aplica_descuento, sp.aplica_recargo, sp.aplica_impuesto, sp.facturable, sp.pago_unico,
				sp.numero_pagos, sp.observaciones,sp.clave, sp.id_producto_servicio);
		}
		
		public function deleteSP(id_producto_servicio:int):AsyncToken
		{
			return serviciosProductosRemote.deleteSP(id_producto_servicio);
		}
	}
}