import Pagination from "react-js-pagination";
import { Header, Title, Bar, Item, ItemTitle, List } from "./style.ts";
import { useState } from "react";
import { ListFooter } from "@/expert/style/global-style.ts";

function HealthFoodList() {
  const [page, setPage] = useState<number>(1);

  const handlePageChange = (page: number) => {
    setPage(page);
    console.log(page);
  };

  const prescriptionList = [
    { name: "오메가-3" },
    { name: "비타민 E" },
    { name: "비타민 A" },
    { name: "비타민 B" },
    { name: "비타민 C" },
    { name: "비타민 D" },
  ];

  return (
    <>
      <Header>
        <Title>복용 중인 건강기능식품</Title>
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

export default HealthFoodList;
