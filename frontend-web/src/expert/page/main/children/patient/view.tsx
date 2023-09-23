import * as S from "./style.ts";
import SpecialNote from "./child/notes/view.tsx";
import Doses from "./child/doses/view.tsx";
import Questionnaires from "./child/questionnaires/view.tsx";
import Prescriptions from "./child/prescriptions/view.tsx";
import HealthFunctionalFoods from "./child/health-functional-foods/view.tsx";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import getAge from "../../../../util/get-age.ts";
import { ESex } from "../../../../type/sex.ts";
import { usePatientPageViewController } from "./view.controller.ts";

type TParam = {
  id: number;
  name: string;
  sex: ESex;
  birthday: number[];
};

function PatientPage() {
  const { isMobile, patientId } = usePatientPageViewController();

  return (
    <S.Outer>
      <S.Header>
        <S.BackButton to="/expert/patient">
          <S.BackIcon />
          환자 목록으로
        </S.BackButton>
      </S.Header>
      <S.PatientSummary>
        <S.NameSex>
          <S.Name>{name}</S.Name>
          <S.Sex>
            {sex === ESex.MALE ? "남성" : "여성"}
            {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
          </S.Sex>
        </S.NameSex>
        <S.Birthday>
          {`${year}.
          ${month < 10 ? "0".concat(month.toString()) : month}.
          ${date < 10 ? "0".concat(date.toString()) : date}. `}
          {!isMobile && `(${getAge(new Date(year, month - 1, date))}세)`}
        </S.Birthday>
      </S.PatientSummary>
      <S.NoteAndDoseList>
        <S.InnerBox>
          <SpecialNote patientId={Number(id)} />
        </S.InnerBox>
        <S.InnerBox>
          <Doses patientId={Number(id)} />
        </S.InnerBox>
      </S.NoteAndDoseList>
      <S.InnerBox>
        <Questionnaires patientId={Number(id)} />
      </S.InnerBox>
      <S.PrescriptionAndHealthFunctionalFood>
        <S.InnerBox>
          <Prescriptions patientId={Number(id)} />
        </S.InnerBox>
        <S.InnerBox>
          <HealthFunctionalFoods patientId={Number(id)} />
        </S.InnerBox>
      </S.PrescriptionAndHealthFunctionalFood>
    </S.Outer>
  );
}

export default PatientPage;
