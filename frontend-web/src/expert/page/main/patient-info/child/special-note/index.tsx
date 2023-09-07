import {
  AddButton,
  Bar,
  DialogBox,
  DialogCancelButton,
  DialogConfirmButton,
  DialogDeleteButton,
  DialogFooter,
  DialogHeader,
  DialogInputBox,
  DialogRecordDate,
  DialogTitle,
  Header,
  Item,
  ItemRecordedDate,
  ItemTitle,
  Label,
  List,
  ListHeader,
  NoteDescriptionInput,
  NoteTitleInput,
  RecordedDateHeader,
  Title,
  TitleHeader,
} from "./style.ts";

import AddOutlinedIcon from "@mui/icons-material/AddOutlined";
import Pagination from "react-js-pagination";
import { useState } from "react";
import { Dialog, useMediaQuery, useTheme } from "@mui/material";
import {
  TNoteItem,
  useCreateNoteMutation,
  useDeleteNoteMutation,
  useGetNoteListQuery,
  useModifyNoteMutation,
} from "../../../../../api/note-list.ts";
import { ListFooter } from "../../../../../style.ts";
import ErrorPage from "../../../../error-page";
import Skeleton from "@mui/material/Skeleton";

type TSpecialNoteProps = {
  patientId: number;
};

const PAGING_PAGE = 5;

function SpecialNote({ patientId }: TSpecialNoteProps) {
  const [createIsOpen, setCreateIsOpen] = useState<boolean>(false);
  const [page, setPage] = useState<number>(1);
  const [currentNote, setCurrentNote] = useState<TNoteItem | null>(null);
  const [currentTitle, setCurrentTitle] = useState<string>("");
  const [currentDescription, setCurrentDescription] = useState<string>("");

  const { data, isError, isLoading } = useGetNoteListQuery({ patientId, page: page - 1 });
  const [triggerCreateNote] = useCreateNoteMutation();
  const [triggerModifyNote] = useModifyNoteMutation();
  const [triggerDeleteNote] = useDeleteNoteMutation();

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

  const handleCreateDialogClose = () => {
    setCreateIsOpen(false);
    setCurrentTitle("");
    setCurrentDescription("");
  };

  const handleModifyDialogSubmit = () => {
    if (currentNote?.id) {
      triggerModifyNote({ noteId: currentNote?.id, title: currentTitle, description: currentDescription });
    }

    handleDialogClose();
  };

  const handleCreateDialogSubmit = () => {
    if (patientId) {
      triggerCreateNote({ patientId, title: currentTitle, description: currentDescription });
    }

    handleCreateDialogClose();
  };

  const handleDeleteDialogSubmit = () => {
    if (currentNote?.id) {
      triggerDeleteNote({ noteId: currentNote?.id });
    }

    handleDialogClose();
  };

  if (isLoading) {
    return <Skeleton variant="rectangular" animation="wave" />;
  }

  if (isError || !data) {
    return <ErrorPage />;
  }

  const noteList: TNoteItem[] = data.datalist;

  return (
    <>
      <Header>
        <Title>특이 사항</Title>
        <AddButton onClick={() => setCreateIsOpen(true)}>
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
        {noteList.map((note) => (
          <Item key={note.id} onClick={handleDialogOpen(note.id)}>
            <ItemTitle>{note.title.length > 15 ? note.title.substring(0, 14).concat("...") : note.title}</ItemTitle>
            <ItemRecordedDate>
              {`${note.createDate[0]}.
              ${note.createDate[1] < 10 ? "0".concat(note.createDate[1].toString()) : note.createDate[1]}.
              ${note.createDate[2] < 10 ? "0".concat(note.createDate[2].toString()) : note.createDate[2]}.`}
            </ItemRecordedDate>
          </Item>
        ))}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={PAGING_PAGE}
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
                currentNote.createDate &&
                `${currentNote.createDate[0]}. ${
                  currentNote.createDate[1] < 10
                    ? "0".concat(currentNote.createDate[1].toString())
                    : currentNote.createDate[1]
                }. ${
                  currentNote.createDate[2] < 10
                    ? "0".concat(currentNote.createDate[2].toString())
                    : currentNote.createDate[2]
                }.`}
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
            <DialogDeleteButton onClick={handleDeleteDialogSubmit}>삭제</DialogDeleteButton>
            <DialogCancelButton onClick={handleDialogClose}>취소</DialogCancelButton>
            <DialogConfirmButton onClick={handleModifyDialogSubmit}>수정</DialogConfirmButton>
          </DialogFooter>
        </DialogBox>
      </Dialog>
      <Dialog open={createIsOpen} onClose={handleCreateDialogClose} fullScreen={fullScreen} keepMounted>
        <DialogBox>
          <DialogHeader>
            <DialogTitle>특이 사항 추가</DialogTitle>
          </DialogHeader>
          <Bar />
          <DialogInputBox>
            <Label>제목</Label>
            <NoteTitleInput value={currentTitle} onChange={(e) => setCurrentTitle(e.target.value)} />
            <Label>내용</Label>
            <NoteDescriptionInput value={currentDescription} onChange={(e) => setCurrentDescription(e.target.value)} />
          </DialogInputBox>
          <DialogFooter>
            <DialogCancelButton onClick={handleDialogClose}>취소</DialogCancelButton>
            <DialogConfirmButton onClick={handleCreateDialogSubmit}>추가</DialogConfirmButton>
          </DialogFooter>
        </DialogBox>
      </Dialog>
    </>
  );
}

export default SpecialNote;
