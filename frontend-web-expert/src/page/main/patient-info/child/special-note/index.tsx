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
  DialogBox,
  DialogCancleButton,
  DialogConfirmButton,
  DialogFooter,
  DialogInputBox,
  DialogTitle,
  NoteTitleInput,
  NoteDescriptionInput,
  Label,
  DialogHeader,
  DialogRecordDate,
} from "./style";

import AddOutlinedIcon from "@mui/icons-material/AddOutlined";
import Pagination from "react-js-pagination";
import { useState } from "react";
import { ListFooter } from "@/style/global-style";
import { Dialog, useMediaQuery, useTheme } from "@mui/material";

type TSpecialNoteProps = {
  patientId: number;
};

type TNoteItem = {
  id: number;
  title: string;
  description: string;
  recorded_at: Date;
};

function SpecialNote({ patientId }: TSpecialNoteProps) {
  const [page, setPage] = useState<number>(1);
  const [currentNote, setCurrentNote] = useState<TNoteItem | null>(null);
  const [currentTitle, setCurrentTitle] = useState<string>("");
  const [currentDescription, setCurrentDescription] = useState<string>("");

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("sm")); // width: 600px

  const handlePageChange = (page: number) => {
    setPage(page);
  };

  const handleDialogOpen = (noteId: number) => () => {
    const note = noteList.findLast((note) => note.id === noteId);

    if (note) {
      setCurrentNote(note);
      setCurrentTitle(note.title);
      setCurrentDescription(note.description);
    }
  };

  const handleDialogClose = () => {
    setCurrentNote(null);
    setCurrentTitle("");
    setCurrentDescription("");
  };

  const noteList: TNoteItem[] = [
    { id: 6, title: "특이사항6", description: "괜찮으십니까?", recorded_at: new Date("2023-08-19") },
    { id: 5, title: "특이사항5", description: "괜찮으십니까?", recorded_at: new Date("2023-08-18") },
    { id: 4, title: "특이사항4", description: "괜찮으십니까?", recorded_at: new Date("2023-08-17") },
    { id: 3, title: "특이사항3", description: "괜찮으십니까?", recorded_at: new Date("2023-08-16") },
    { id: 2, title: "특이사항2", description: "괜찮으십니까?", recorded_at: new Date("2023-08-15") },
    {
      id: 1,
      title: "특이사항1",
      description: "괜찮으십니까?",
      recorded_at: new Date("2023-08-14"),
    },
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
          <Item key={note.id} onClick={handleDialogOpen(note.id)}>
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
      <Dialog open={currentNote !== null} onClose={handleDialogClose} fullScreen={fullScreen} keepMounted>
        <DialogBox>
          <DialogHeader>
            <DialogTitle>특이 사항 수정</DialogTitle>
            <DialogRecordDate>
              {"기록일: "}
              {currentNote &&
                `${currentNote.recorded_at.getFullYear()}.
              ${
                currentNote.recorded_at.getMonth() + 1 < 10
                  ? "0".concat((currentNote.recorded_at.getMonth() + 1).toString())
                  : currentNote.recorded_at.getMonth() + 1
              }.
              ${currentNote.recorded_at.getDate()}.`}
            </DialogRecordDate>
          </DialogHeader>
          <Bar />
          <DialogInputBox>
            <Label>제목</Label>
            <NoteTitleInput value={currentTitle} onChange={(e) => setCurrentTitle(e.target.value)} />
            <Label>내용</Label>
            <NoteDescriptionInput value={currentDescription} onChange={(e) => setCurrentDescription(e.target.value)} />
          </DialogInputBox>
          <DialogFooter>
            <DialogCancleButton onClick={handleDialogClose}>취소</DialogCancleButton>
            <DialogConfirmButton onClick={handleDialogClose}>수정</DialogConfirmButton>
          </DialogFooter>
        </DialogBox>
      </Dialog>
    </>
  );
}

export default SpecialNote;
