package us.educative.models
{
	import mx.collections.ArrayCollection;

import us.educative.VO.PeriodoVO;

[Bindable]
	public class PeriodoModel
	{
        public var cicloVigente:PeriodoVO = new PeriodoVO();
		public var periodoList:ArrayCollection;
		public function PeriodoModel()
		{
            cicloVigente.id_periodo = 3;
            cicloVigente.nombre = "2015-2016";
            cicloVigente.fecha_inicial = "2014-08-18";
            cicloVigente.fecha_final = "2015-07-14";
		}
	}
}