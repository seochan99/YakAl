import Pagination from "react-js-pagination";
import { Header, Title, Bar, Item, ItemTitle, List } from "./style.ts";
import { useState } from "react";
import { ListFooter } from "@/expert/style.ts";

function PrescriptionList() {
  const [page, setPage] = useState<number>(1);

  const handlePageChange = (page: number) => {
    setPage(page);
    console.log(page);
  };

  const prescriptionList = [{ name: "우울증" }, { name: "고혈압" }, { name: "당뇨" }];

  return (
    <>
      <Header>
        <Title>이전 처방 목록</Title>
      </Header>
      <Bar />
      <List>
        {prescriptionList.slice(5 * (page - 1), 5 * page).map((prescription) => (
          <Item key={prescription.name}>
            <ItemTitle>
              {prescription.name.length > 15 ? prescription.name.substring(0, 14).concat("...") : prescription.name}
            </ItemTitle>
          </Item>
        ))}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={5}
          totalItemsCount={prescriptionList.length}
          pageRangeDisplayed={3}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </>
  );
}

export default PrescriptionList;
