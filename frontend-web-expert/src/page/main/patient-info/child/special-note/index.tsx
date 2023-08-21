import {
  Bar,
  ItemRecordedDate,
  RecordedDateHeader,
  ItemTitle,
  TitleHeader,
  Item,
  List,
  ListHeader,
  Title,
  Header,
  AddButton,
  ListFooter,
} from "./style";

import AddOutlinedIcon from "@mui/icons-material/AddOutlined";
import Pagination from "react-js-pagination";
import { useState } from "react";

type TSpecialNoteProps = {
  patientId: number;
};

function SpecialNote({ patientId }: TSpecialNoteProps) {
  const [page, setPage] = useState<number>(1);

  const handlePageChange = (page: number) => {
    setPage(page);
    console.log(page);
  };

  const noteList = [
    {
      id: 1,
      title: "특이사항1",
      description: "괜찮으십니까?",
      recorded_at: new Date("2023-08-14"),
    },
    { id: 2, title: "특이사항2", description: "괜찮으십니까?", recorded_at: new Date("2023-08-15") },
    { id: 3, title: "특이사항3", description: "괜찮으십니까?", recorded_at: new Date("2023-08-16") },
    { id: 4, title: "특이사항4", description: "괜찮으십니까?", recorded_at: new Date("2023-08-17") },
    { id: 5, title: "특이사항5", description: "괜찮으십니까?", recorded_at: new Date("2023-08-18") },
    { id: 6, title: "특이사항6", description: "괜찮으십니까?", recorded_at: new Date("2023-08-19") },
  ];

  return (
    <>
      <Header>
        <Title>특이 사항</Title>
        <AddButton>
          <AddOutlinedIcon />
          추가
        </AddButton>
      </Header>
      <Bar />
      <List>
        <ListHeader>
          <TitleHeader>제목</TitleHeader>
          <RecordedDateHeader>기록일</RecordedDateHeader>
        </ListHeader>
        {noteList.slice(5 * (page - 1), 5 * page).map((note) => (
          <Item key={note.id}>
            <ItemTitle>{note.title.length > 15 ? note.title.substring(0, 14).concat("...") : note.title}</ItemTitle>
            <ItemRecordedDate>
              {`${note.recorded_at.getFullYear()}.
              ${
                note.recorded_at.getMonth() + 1 < 10
                  ? "0".concat((note.recorded_at.getMonth() + 1).toString())
                  : note.recorded_at.getMonth() + 1
              }.
              ${note.recorded_at.getDate()}.`}
            </ItemRecordedDate>
          </Item>
        ))}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={5}
          totalItemsCount={noteList.length}
          pageRangeDisplayed={3}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </>
  );
}

export default SpecialNote;
