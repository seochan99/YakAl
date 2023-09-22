import * as S from "./style.ts";

export type TPrescriptionListProps = {
  patientId: number;
};

function Prescriptions() {
  return (
    <>
      <S.Header>
        <S.Title>이전 처방 목록</S.Title>
      </S.Header>
      <S.Bar />
      <S.List>
        <S.Item key={"치매"}>
          <S.ItemTitle>{"치매".length > 15 ? "치매".substring(0, 14).concat("...") : "치매"}</S.ItemTitle>
        </S.Item>
      </S.List>
    </>
  );
}

export default Prescriptions;
