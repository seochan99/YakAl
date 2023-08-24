import PatientItem from "@/page/main/patient-list/child/patient-item";
import {
  Outer,
  PageButton,
  PageLeftButton,
  PageRightButton,
  PagingButtonBox,
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
} from "./style";
import { useLoaderData } from "react-router-dom";
import { TPatientLoaderReturn } from "./loader";

function PatientList() {
  const { userList } = useLoaderData() as TPatientLoaderReturn;

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
        {userList.map((user) => {
          return <PatientItem key={user.id} userInfo={user} />;
        })}
      </List>
      <PagingButtonBox>
        <PageLeftButton />
        <PageButton>1</PageButton>
        <PageButton>2</PageButton>
        <PageButton>3</PageButton>
        <PageRightButton />
      </PagingButtonBox>
    </Outer>
  );
}

export default PatientList;
