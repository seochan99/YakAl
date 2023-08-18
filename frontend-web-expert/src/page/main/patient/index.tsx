import PatientItem from "@/component/patient-item";
import {
  Outer,
  PageButton,
  PageLeftButton,
  PageRightButton,
  PagingButtonBox,
  PatientInfoContainer,
  PatientListContainer,
  PatientListHr,
  PatientList,
  SearchButton,
  SearchInput,
  SearchPatient,
} from "./style";
import { ESex } from "@/type/sex";
import { Outlet } from "react-router-dom";

function Patient() {
  return (
    <Outer>
      <PatientListContainer>
        <SearchPatient>
          <SearchButton />
          <SearchInput type="text" placeholder="환자 검색" />
        </SearchPatient>
        <PatientList>
          <PatientItem id={1} name="홍길동" sex={ESex.MALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={2} name="홍길동" sex={ESex.FEMALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={3} name="홍길동" sex={ESex.MALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={4} name="홍길동" sex={ESex.FEMALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={5} name="홍길동" sex={ESex.MALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={6} name="홍길동" sex={ESex.FEMALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={7} name="홍길동" sex={ESex.MALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={8} name="홍길동" sex={ESex.FEMALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={9} name="홍길동" sex={ESex.MALE} birthday={new Date("200-01-01")} />
          <PatientListHr />
          <PatientItem id={10} name="홍길동" sex={ESex.FEMALE} birthday={new Date("200-01-01")} />
        </PatientList>
        <PagingButtonBox>
          <PageLeftButton />
          <PageButton>1</PageButton>
          <PageButton>2</PageButton>
          <PageButton>3</PageButton>
          <PageRightButton />
        </PagingButtonBox>
      </PatientListContainer>
      <PatientInfoContainer>
        <Outlet />
      </PatientInfoContainer>
    </Outer>
  );
}

export default Patient;
