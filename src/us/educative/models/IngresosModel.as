/**
 * Created by carlos on 17/09/14.
 */
package us.educative.models {
import mx.collections.ArrayCollection;

[Bindable]
public class IngresosModel {
	public var listadoPagos:ArrayCollection;
	public var listadoPagosDetalle:ArrayCollection;
    public var listadoGruposIngresos:ArrayCollection;
    public var listadoAlumnos:ArrayCollection;
    public var listadoConceptos:ArrayCollection;
    public var listadoMeses:ArrayCollection = new ArrayCollection([{label:"Enero", data:"1"},
        {label:"Febrero", data:"2"},
        {label:"Marzo", data:"3"},
        {label:"Abril", data:"4"},
        {label:"Mayo", data:"5"},
        {label:"Junio", data:"6"},
        {label:"Julio", data:"7"},
        {label:"Agosto", data:"8"},
        {label:"Septiembre", data:"9"},
        {label:"Octubre", data:"10"},
        {label:"Noviembre", data:"11"},
        {label:"Diciembre", data:"12"},])
    public function IngresosModel() {
    }
}
}
