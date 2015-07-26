/**
 * Created by carlos on 8/9/14.
 */
package us.educative.VO {
[Bindable]
public class ServiciosProductosVO {
    public var id_producto_servicio:int;
    public var tipo_concepto:String;
    public var concepto:String;
    public var periodo_id:int;
    public var nivel_educativo_id:int;
    public var precio_general:Number;
    public var precio_publico:Number;
    public var aplica_descuento:int;
    public var aplica_recargo:int;
    public var aplica_impuesto:int;
    public var facturable:int;
    public var pago_unico:int;
    public var numero_pagos:int;
    public var observaciones:String;
    public var clave:String;
    public function ServiciosProductosVO() {

    }
}
}
