import { Bar, Header, Item, ItemTitle, List, Title } from "./style.ts";

export type THealthFoodListProps = {
  patientId: number;
};

function HealthFoodList() {
  return (
    <>
      <Header>
        <Title>복용 중인 건강기능식품</Title>
      </Header>
      <Bar />
      <List>
        <Item key={"고혈압"}>
          <ItemTitle>{"고혈압".length > 15 ? "고혈압".substring(0, 14).concat("...") : "고혈압"}</ItemTitle>
        </Item>
      </List>
    </>
  );
}

export default HealthFoodList;
