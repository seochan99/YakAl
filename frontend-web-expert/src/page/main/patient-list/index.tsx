import PatientItem from "@/component/patient-item";
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
        {userList.map((user) => {
          return <PatientItem key={user.id} id={user.id} name={user.name} sex={user.sex} birthday={user.birthday} />;
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
