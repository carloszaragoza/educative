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
			/* llenar este modelo al inicio con la informacion del periodo vigente.
            cicloVigente.id_periodo = 2;
            cicloVigente.nombre = "2019-2020";
            cicloVigente.fecha_inicial = "2019-08-26";
            cicloVigente.fecha_final = "2020-07-03";*/
		}
	}
}
