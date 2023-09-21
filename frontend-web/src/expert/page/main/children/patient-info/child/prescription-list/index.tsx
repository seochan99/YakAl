import { Bar, Header, Item, ItemTitle, List, Title } from "./style.ts";

export type TPrescriptionListProps = {
  patientId: number;
};

function PrescriptionList() {
  return (
    <>
      <Header>
        <Title>이전 처방 목록</Title>
      </Header>
      <Bar />
      <List>
        <Item key={"치매"}>
          <ItemTitle>{"치매".length > 15 ? "치매".substring(0, 14).concat("...") : "치매"}</ItemTitle>
        </Item>
      </List>
    </>
  );
}

export default PrescriptionList;
