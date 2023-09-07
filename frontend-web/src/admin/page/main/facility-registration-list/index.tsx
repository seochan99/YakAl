import {
  DirectorName,
  DirectorPhone,
  FacilityType,
  List,
  Name,
  OptionBar,
  Outer,
  RequestedAt,
  SearchBar,
  SearchButton,
  SearchInput,
  TableHeader,
  Title,
} from "./style.ts";
import { ReactNode, useState } from "react";
import { ListFooter } from "../../../style.ts";
import Pagination from "react-js-pagination";
import FacilityItem from "./child/facility-item";
import { EFacility } from "../../../../expert/type/facility.ts";

export type TFacility = {
  id: number;
  type: EFacility;
  directorPhone: string;
  directorName: string;
  name: string;
  requested_at: Date;
};

const PAGING_SIZE = 10;

const facilityList = [
  {
    id: 1,
    type: EFacility.HOSPITAL,
    directorPhone: "01022222222",
    directorName: "조차현",
    name: "분당 차병원!",
    requested_at: new Date("2023-09-07"),
  },
];

export function FacilityRegistration() {
  const [page, setPage] = useState<number>(1);

  const getDummyList = (): ReactNode[] => {
    const dummyList: ReactNode[] = [];

    if (PAGING_SIZE * page <= facilityList.length) {
      return dummyList;
    }

    for (let i = 0; i < PAGING_SIZE - (facilityList.length % PAGING_SIZE); ++i) {
      dummyList.push(<FacilityItem key={i} />);
    }
    return dummyList;
  };

  const handlePageChange = (page: number) => {
    setPage(page);
  };

  return (
    <Outer>
      <Title>기관 등록 신청 내역</Title>
      <OptionBar>
        <SearchBar>
          <SearchButton />
          <SearchInput type="text" placeholder="기관명으로 검색" />
        </SearchBar>
      </OptionBar>
      <List>
        <TableHeader>
          <FacilityType>{`기관 종류`}</FacilityType>
          <DirectorName>{`기관장명`}</DirectorName>
          <DirectorPhone>{`기관장 연락처`}</DirectorPhone>
          <Name>{`기관명`}</Name>
          <RequestedAt>{`등록 요청일`}</RequestedAt>
        </TableHeader>
        {facilityList.slice(PAGING_SIZE * (page - 1), PAGING_SIZE * page).map((facility) => {
          return <FacilityItem facility={facility} key={facility.id} />;
        })}
        {getDummyList()}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={10}
          totalItemsCount={facilityList.length}
          pageRangeDisplayed={5}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </Outer>
  );
}
