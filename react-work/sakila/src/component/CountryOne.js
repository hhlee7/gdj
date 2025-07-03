import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom"

export default function CountryOne() {
    const {countryId} = useParams();
    const [country, setCountry] = useState({});

    useEffect(() => {
        fetch(`http://localhost/countryOne/${countryId}`)
        .then((res) => {return res.json()})
        .then((data) => {setCountry(data)})
    }, []);

    return (
        <div className="p-6">
            
            <h1 className="text-2xl font-bold mb-4">
                CountryOne
            </h1>

            {/* city 입력 폼 컴포넌트로 이동 */}
            <Link className="text-blue-600 hover:underline" to={`/AddCity/${country.countryId}`}>add city</Link>

            <table className="table-auto border-collapse border border-gray-300 mb-4">
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
            <button className="px-3 py-1 border rounded hover:bg-gray-100">삭제</button>
            <button className="px-3 py-1 border rounded hover:bg-gray-100">수정</button>
        </div>
    )
}
