import * as S from "./style.ts";

type TPatientInfoTextProps = {
  text: string;
};

function PatientNotFound({ text }: TPatientInfoTextProps) {
  return (
    <S.Outer>
      <S.Text>{text}</S.Text>
    </S.Outer>
  );
}

export default PatientNotFound;
