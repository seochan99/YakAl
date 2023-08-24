import PatientItem from "@/page/main/patient-list/child/patient-item";
import {
  Outer,
  List,
  SearchButton,
  SearchInput,
  OptionBar,
  Birthday,
  Risk,
  Name,
  Sex,
  TableHeader,
  TestProgress,
  ListFooter,
} from "./style";
import { useLoaderData } from "react-router-dom";
import { TPatientLoaderReturn } from "./loader";
import Pagination from "react-js-pagination";
import { useState } from "react";

function PatientList() {
  const { userList } = useLoaderData() as TPatientLoaderReturn;

  const [page, setPage] = useState<number>(1);

  const handlePageChange = (page: number) => {
    setPage(page);
    console.log(page);
  };

  return (
    <Outer>
      <OptionBar>
        <SearchButton />
        <SearchInput type="text" placeholder="환자 검색" />
      </OptionBar>
      <List>
        <TableHeader>
          <Name>{`이름`}</Name>
          <Sex>{`성별`}</Sex>
          <TestProgress>{`설문 완료율`}</TestProgress>
          <Risk>{`위험군 약 개수`}</Risk>
          <Birthday>{`생년월일(만 나이)`}</Birthday>
        </TableHeader>
        {userList.slice(10 * (page - 1), 10 * page).map((user) => {
          return <PatientItem key={user.id} userInfo={user} />;
        })}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={10}
          totalItemsCount={userList.length}
          pageRangeDisplayed={5}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </Outer>
  );
}

export default PatientList;
