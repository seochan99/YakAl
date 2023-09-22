import * as S from "./style.ts";

export type THealthFoodListProps = {
  patientId: number;
};

function HealthFunctionalFoods() {
  return (
    <>
      <S.Header>
        <S.Title>복용 중인 건강기능식품</S.Title>
      </S.Header>
      <S.Bar />
      <S.List>
        <S.Item key={"고혈압"}>
          <S.ItemTitle>{"고혈압".length > 15 ? "고혈압".substring(0, 14).concat("...") : "고혈압"}</S.ItemTitle>
        </S.Item>
      </S.List>
    </>
  );
}

export default HealthFunctionalFoods;
