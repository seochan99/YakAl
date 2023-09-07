import { Bar, Header, Item, ItemTitle, List, Title } from "./style.ts";
import { useGetHealthFoodQuery } from "../../../../../api/healthfood.ts";
import LoadingPage from "../../../../loading-page";
import ErrorPage from "../../../../error-page";

type THealthFoodListProps = {
  patientId: number;
};

function HealthFoodList({ patientId }: THealthFoodListProps) {
  const { data, isLoading, isError } = useGetHealthFoodQuery({ patientId });

  if (isLoading) {
    return <LoadingPage />;
  }

  if (isError || !data) {
    return <ErrorPage />;
  }

  const slice = data.length > 5 ? data.slice(0, 4) : data;

  return (
    <>
      <Header>
        <Title>복용 중인 건강기능식품</Title>
      </Header>
      <Bar />
      <List>
        {slice.map((prescription) => (
          <Item key={prescription.name}>
            <ItemTitle>
              {prescription.name.length > 15 ? prescription.name.substring(0, 14).concat("...") : prescription.name}
            </ItemTitle>
          </Item>
        ))}
      </List>
    </>
  );
}

export default HealthFoodList;
