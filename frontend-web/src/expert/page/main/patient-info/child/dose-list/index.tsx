import Pagination from "react-js-pagination";
import {
  Bar,
  DateHeader,
  GreenIcon,
  Header,
  Item,
  ItemDate,
  ItemIcon,
  ItemTitle,
  List,
  ListHeader,
  PeriodItem,
  PeriodItemButton,
  PeriodList,
  PeriodSelectBox,
  PeriodSelectButton,
  QuestionIcon,
  RedIcon,
  RiskHeader,
  Title,
  TitleHeader,
  YellowIcon,
} from "./style.ts";
import { useEffect, useRef, useState } from "react";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { ListFooter } from "../../../../../style.ts";
import { EPeriod } from "../../../../../type/period.ts";
import { useGetDoseListQuery } from "../../../../../api/dose-list.ts";
import LoadingPage from "../../../../loading-page";
import ErrorPage from "../../../../error-page";
import axios from "axios";

type TDoseListProps = {
  patientId: number;
};

const PAGING_SIZE = 5;

function DoseList({ patientId }: TDoseListProps) {
  const [page, setPage] = useState<number>(1);
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [selected, setSelected] = useState<number>(5);
  const [drugName, setDrugName] = useState<Map<string, string>>(new Map<string, string>());

  const { data, isError, isLoading } = useGetDoseListQuery({
    patientId,
    page: page - 1,
    period: Object.keys(EPeriod)[selected],
  });

  const periodListRef = useRef<HTMLUListElement>(null);

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (periodListRef.current) {
        if (!(e.target instanceof Node) || !periodListRef.current.contains(e.target)) {
          if (isOpen) {
            setTimeout(() => setIsOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [isOpen]);

  useEffect(() => {
    if (!data) {
      return;
    }

    const map = new Map<string, string>();

    for (const doseItem in data.prescribedList) {
      axios
        .get(`${import.meta.env.VITE_KIMS_HOST}?drugcode=${doseItem.kdcode}&drugType=N`, {
          headers: {
            Authorization: `Basic ${btoa(
              import.meta.env.VITE_KIMS_USERNAME + ":" + import.meta.env.VITE_KIMS_PASSWORD,
            )}`,
          },
        })
        .then((response) => {
          map.set(doseItem.kdcode, response.name);
        })
        .catch(() => {
          map.set(doseItem.kdcode, "알수없음");
        });
    }
  }, [data]);

  const handlePageChange = (page: number) => {
    setPage(page);
  };

  const handleSelect = (period: number) => () => {
    setSelected(period);
    setIsOpen(false);
  };

  const getRiskIcon = (polypharmacyRisk: number) => {
    switch (polypharmacyRisk) {
      case 0:
      case 1:
        return <GreenIcon />;
      case 2:
        return <YellowIcon />;
      case 3:
        return <RedIcon />;
      default:
        return <QuestionIcon />;
    }
  };

  if (isLoading) {
    return <LoadingPage />;
  }

  if (isError || !data) {
    return <ErrorPage />;
  }

  const doseList = data.prescribedList;

  return (
    <>
      <Header>
        <Title>복약 목록</Title>
        <PeriodSelectBox data-role="selectbox">
          <PeriodSelectButton className={isOpen ? "open" : ""} onClick={() => setIsOpen(!isOpen)}>
            <ArrowDropDownIcon />
            <span>{Object.values(EPeriod)[selected]}</span>
          </PeriodSelectButton>
          {isOpen && (
            <PeriodList ref={periodListRef}>
              {[0, 1, 2, 3, 4, 5].map((period) => {
                return (
                  <PeriodItem key={period}>
                    <PeriodItemButton onClick={handleSelect(period)}>{Object.values(EPeriod)[period]}</PeriodItemButton>
                  </PeriodItem>
                );
              })}
            </PeriodList>
          )}
        </PeriodSelectBox>
      </Header>
      <Bar />
      <List>
        <ListHeader>
          <TitleHeader>약품명</TitleHeader>
          <RiskHeader>위험도</RiskHeader>
          <DateHeader>처방일</DateHeader>
        </ListHeader>
        {doseList.map((dose) => (
          <Item key={dose.kdcode}>
            <ItemTitle>{dose.kdcode.length > 9 ? dose.kdcode.substring(0, 8).concat("...") : dose.kdcode}</ItemTitle>
            <ItemIcon>{getRiskIcon(dose.score)}</ItemIcon>
            <ItemDate>
              {`${dose.prescribedDate[0]}. ${
                dose.prescribedDate[1] < 10 ? "0".concat(dose.prescribedDate[1].toString()) : dose.prescribedDate[1]
              }. ${
                dose.prescribedDate[2] < 10 ? "0".concat(dose.prescribedDate[2].toString()) : dose.prescribedDate[2]
              }.`}
            </ItemDate>
          </Item>
        ))}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={PAGING_SIZE}
          totalItemsCount={data.totalCount}
          pageRangeDisplayed={3}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </>
  );
}

export default DoseList;
