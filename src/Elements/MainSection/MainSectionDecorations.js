import styled from 'styled-components'
import { MdKeyboardArrowRight, MdArrowForward} from 'react-icons/md'
import { Link as LinkS } from 'react-scroll'

export const MainContainer = styled.div`
    background: #070E08;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0 30px;
    /* height: 1000px; wersja dla wielu sekcji*/
    height: 750px;
    position: relative;
    z-index: 1;

`;

export const Background = styled.div`
    height:100%;
    width:100%;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    overflow: hidden;
    /* background-color: #020202; */
`;

export const VideoBackground = styled.video`
    width: 100%;
    height: 100%;
    -o-object-fit: cover;
    object-fit: cover;
    /* background: #030303; */
`;

export const MainContent = styled.div`
    z-index: 3;
    max-width: 1200px;
    margin-bottom: -500px;
    position: absolute;
    padding: 8px 24px;
    display: flex;
    flex-direction: column;
    align-items:center;
`;

export const ImageUploadContent = styled.div`
    z-index: 1;
    max-width: 1200px;
    height: 420px;
    position: absolute;
    padding: 8px 24px;
    display: flex;
    flex-direction: column;
    align-items:center;
`;



export const InputBar = styled.input`
    background-color: white;
    background: white;
    z-index: -1;
    position:relative;
    /* left: 20%; */
    resize: horizontal;
    top: -35%;
    width: 330px;
    height: 42px;
    border-radius: 20px;
    border-color: white;
    text-align: center;
    font-size:1.3rem;
    text-decoration: none;

    &:active{
        width:auto;
        border-radius: 20px;
    }
    &:focus{
        min-width: 270px;
        border-radius: 20px;
    }
`;
export const MainButtonWrapper = styled.div`
    margin-top: 32px;
    /* margin-left: -60%; */
    display: flex;
    flex-direction: column;
    align-items: center;
`;

export const ArrowForward = styled(MdArrowForward)`
    margin-left: 8px;
    font-size: 20px;
    background: #010606;

    Button:hover{
        background: #01bf71;
    }
    
    
`;

export const Button = styled(LinkS)`
    border-radius: 50px;
    white-space: nowrap;
    /* background: ${({primary}) => (primary ? '#010606' : '#01bf71')};
    padding: ${({big}) => (big ? '14 px 48px' : '12px 30px')};
    color: ${({dark}) => (dark ? '#01bf71' : '#fff')};
    font-size: ${({fontBig}) => (fontBig ? '20px' : '16px')}; */
    background: #01bf71;
    padding: 12px 30px;
    color: #fff;
    font-size: 20px;
    outline: none;
    border: none;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: all 0.2s ease-in-out;

    &:hover{
        transition: all 0.2s ease-in-out;
        background: ${({primary}) => (primary ? '#fff' : '#fff')}; 
        color: #010606;
    }
`;

export const ImageUploadWrapper = styled.div`


`;

export const ImageButtonWrapper = styled.div`
    margin-top: 32px;
    /* top: 10%; */
    /* margin-left: -60%; */
    display: flex;
    flex-direction: column;
    align-items: center;    

`;


export const ImagePreview = styled.div`
    width:16rem;
    height:14rem;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    margin-bottom: 1rem;
    clip-path: circle(50% at 50% 50%);
    position: absolute;
    top: 60%;
    left: 50%;
    -ms-transform: translate(-50%,-50%);
    transform: translate(-50%,-50%);

`;

export const FooterWrapper = styled.footer`
    color: #fff;
    text-align: center;
    text-decoration: none;
    background-color: #0c0c0c;
    bottom: 0%;
    width: 100%;
    font-size: 0.7rem;
    padding: 10px 10px 10px 10px;
    position: fixed;
    z-index: 3;

`;





