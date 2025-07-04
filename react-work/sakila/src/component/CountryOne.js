import { useEffect, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom"

export default function CountryOne() {
    const {countryId} = useParams();
    const [country, setCountry] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
        fetch(`http://localhost/countryOne/${countryId}`)
        .then((res) => {return res.json()})
        .then((data) => {setCountry(data)})
    }, []);

    function remove() {
        if(window.confirm('삭제하시겠습니까?')) {
            fetch(`http://localhost/country/${countryId}`, {method: 'DELETE'})
            .then((res) => {
                if(res.ok) { // http code : 200
                    navigate('/Country');
                } else { // http code : 400, 500
                    window.alert('삭제 실패');
                }
            })
        } else {
            alert('삭제를 취소합니다.')
        }
    }

    return (
        <div className="flex flex-col items-center mt-6">

            <h1 className="text-2xl font-bold mb-4">
                CountryOne
            </h1>

            {/* city 입력 폼 컴포넌트로 이동 */}
            <Link className="text-blue-600 hover:underline" to={`/AddCity/${country.countryId}`}>add city</Link>

            <table className="table-auto border-collapse border border-gray-300 mt-4 mb-4">
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">countryId</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{country.countryId}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">country</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{country.country}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">lastUpdate</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{country.lastUpdate}</td>
                </tr>
            </table>
            <div className="flex flex-row gap-2 mt-2">
                {/* <Link to="/EditCountry">수정</Link> */}
                <button className="px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition" onClick={() => {navigate(`/EditCountry/${countryId}`)}}>수정</button>
                <button className="px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition" onClick={remove}>삭제</button>
            </div>
        </div>
    )
}
