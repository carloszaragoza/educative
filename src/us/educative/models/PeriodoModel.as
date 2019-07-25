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
            cicloVigente.id_periodo = 5;
            cicloVigente.nombre = "2017 - 2018";
            cicloVigente.fecha_inicial = "2017-08-28";
            cicloVigente.fecha_final = "2018-07-06";
		}
	}
}