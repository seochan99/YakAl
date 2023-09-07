import { Bar, Header, Item, ItemTitle, List, Title } from "./style.ts";
import LoadingPage from "../../../../loading-page";
import ErrorPage from "../../../../error-page";
import { useGetHistoryQuery } from "../../../../../api/history.ts";

type TPrescriptionListProps = {
  patientId: number;
};

function PrescriptionList({ patientId }: TPrescriptionListProps) {
  const { data, isLoading, isError } = useGetHistoryQuery({ patientId });

  if (isLoading) {
    return <LoadingPage />;
  }

  if (isError || !data) {
    return <ErrorPage />;
  }

  const slice = data.length > 5 ? data.slice(0, 5) : data;

  return (
    <>
      <Header>
        <Title>이전 처방 목록</Title>
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

export default PrescriptionList;
