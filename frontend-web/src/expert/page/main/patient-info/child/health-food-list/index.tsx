import { Bar, Header, Item, ItemTitle, List, Title } from "./style.ts";
import { useGetHealthFoodQuery } from "../../../../../api/healthfood.ts";
import ErrorPage from "../../../../error-page";
import Skeleton from "@mui/material/Skeleton";

type THealthFoodListProps = {
  patientId: number;
};

function HealthFoodList({ patientId }: THealthFoodListProps) {
  const { data, isLoading, isError } = useGetHealthFoodQuery({ patientId });

  if (isLoading) {
    return <Skeleton variant="rectangular" animation="wave" />;
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
