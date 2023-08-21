import PatientItem from "@/component/patient-item";
import {
  Outer,
  PageButton,
  PageLeftButton,
  PageRightButton,
  PagingButtonBox,
  PatientList,
  SearchButton,
  SearchInput,
  SearchPatient,
} from "./style";
import { useLoaderData } from "react-router-dom";
import { TPatientLoaderReturn } from "./loader";

function Patient() {
  const { userList } = useLoaderData() as TPatientLoaderReturn;

  return (
    <Outer>
      <SearchPatient>
        <SearchButton />
        <SearchInput type="text" placeholder="환자 검색" />
      </SearchPatient>
      <PatientList>
        {userList.map((user) => {
          return <PatientItem key={user.id} id={user.id} name={user.name} sex={user.sex} birthday={user.birthday} />;
        })}
      </PatientList>
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

export default Patient;
