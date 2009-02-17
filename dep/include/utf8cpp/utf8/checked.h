// Copyright 2006 Nemanja Trifunovic

/*
Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
*/


#ifndef UTF8_FOR_CPP_CHECKED_H_2675DCD0_9480_4c0c_B92A_CC14C027B731
#define UTF8_FOR_CPP_CHECKED_H_2675DCD0_9480_4c0c_B92A_CC14C027B731

#include "core.h"
#include <stdexcept>

namespace utf8
{
    // Exceptions that may be thrown from the library functions.
    class invalid_code_point : public std::exception {
        uint32_t cp;
    public:
        invalid_code_point(uint32_t cp) : cp(cp) {}
        virtual const char* what() const throw() { return "Invalid code point"; }
        uint32_t code_point() const {return cp;}
    };

    class invalid_utf8 : public std::exception {
        uint8_t u8;
    public:
        invalid_utf8 (uint8_t u) : u8(u) {}
        virtual const char* what() const throw() { return "Invalid UTF-8"; }
        uint8_t utf8_octet() const {return u8;}
    };

    class invalid_utf16 : public std::exception {
        uint16_t u16;
    public:
        invalid_utf16 (uint16_t u) : u16(u) {}
        virtual const char* what() const throw() { return "Invalid UTF-16"; }
        uint16_t utf16_word() const {return u16;}
    };

    class not_enough_room : public std::exception {
    public:
        virtual const char* what() const throw() { return "Not enough space"; }
    };

    /// The library API - functions intended to be called by the users

    template <typename octet_iterator, typename output_iterator>
    output_iterator replace_invalid(octet_iterator start, octet_iterator end, output_iterator out, uint32_t replacement)
    {
        while (start != end) {
            octet_iterator sequence_start = start;
            internal::utf_error err_code = internal::validate_next(start, end);
            switch (err_code) {
                case internal::OK :
                    for (octet_iterator it = sequence_start; it != start; ++it)
                        *out++ = *it;
                    break;
                case internal::NOT_ENOUGH_ROOM:
                    throw not_enough_room();
                case internal::INVALID_LEAD:
                    append (replacement, out);
                    ++start;
                    break;
                case internal::INCOMPLETE_SEQUENCE:
                case internal::OVERLONG_SEQUENCE:
                case internal::INVALID_CODE_POINT:
                    append (replacement, out);
                    ++start;
                    // just one replacement mark for the sequence
                    while (internal::is_trail(*start) && start != end)
                        ++start;
                    break;
            }
        }
        return out;
    }

    template <typename octet_iterator, typename output_iterator>
    inline output_iterator replace_invalid(octet_iterator start, octet_iterator end, output_iterator out)
    {
        static const uint32_t replacement_marker = internal::mask16(0xfffd);
        return replace_invalid(start, end, out, replacement_marker);
    }

    template <typename octet_iterator>
    octet_iterator append(uint32_t cp, octet_iterator result)
    {
        if (!internal::is_code_point_valid(cp))
            throw invalid_code_point(cp);

        if (cp < 0x80)                        // one octet
            *(result++) = static_cast<uint8_t>(cp);
        else if (cp < 0x800) {                // two octets
            *(result++) = static_cast<uint8_t>((cp >> 6)            | 0xc0);
            *(result++) = static_cast<uint8_t>((cp & 0x3f)          | 0x80);
        }
        else if (cp < 0x10000) {              // three octets
            *(result++) = static_cast<uint8_t>((cp >> 12)           | 0xe0);
            *(result++) = static_cast<uint8_t>((cp >> 6) & 0x3f     | 0x80);
            *(result++) = static_cast<uint8_t>((cp & 0x3f)          | 0x80);
        }
        else if (cp <= internal::CODE_POINT_MAX) {      // four octets
            *(result++) = static_cast<uint8_t>((cp >> 18)           | 0xf0);
            *(result++) = static_cast<uint8_t>((cp >> 12)& 0x3f     | 0x80);
            *(result++) = static_cast<uint8_t>((cp >> 6) & 0x3f     | 0x80);
            *(result++) = static_cast<uint8_t>((cp & 0x3f)          | 0x80);
        }
        else
            throw invalid_code_point(cp);

        return result;
    }

    template <typename octet_iterator>
    uint32_t next(octet_iterator& it, octet_iterator end)
    {
        uint32_t cp = 0;
        internal::utf_error err_code = internal::validate_next(it, end, &cp);
        switch (err_code) {
            case internal::OK :
                break;
            case internal::NOT_ENOUGH_ROOM :
                throw not_enough_room();
            case internal::INVALID_LEAD :
            case internal::INCOMPLETE_SEQUENCE :
            case internal::OVERLONG_SEQUENCE :
                throw invalid_utf8(*it);
            case internal::INVALID_CODE_POINT :
                throw invalid_code_point(cp);
        }
        return cp;
    }

    template <typename octet_iterator>
    uint32_t peek_next(octet_iterator it, octet_iterator end)
    {
        return next(it, end);
    }

    template <typename octet_iterator>
    uint32_t prior(octet_iterator& it, octet_iterator start)
    {
        octet_iterator end = it;
        while (internal::is_trail(*(--it)))
            if (it < start)
                throw invalid_utf8(*it); // error - no lead byte in the sequence
        octet_iterator temp = it;
        return next(temp, end);
    }

    /// Deprecated in versions that include "prior"
    template <typename octet_iterator>
    uint32_t previous(octet_iterator& it, octet_iterator pass_start)
    {
        octet_iterator end = it;
        while (internal::is_trail(*(--it)))
            if (it == pass_start)
                throw invalid_utf8(*it); // error - no lead byte in the sequence
        octet_iterator temp = it;
        return next(temp, end);
    }

    template <typename octet_iterator, typename distance_type>
    void advance (octet_iterator& it, distance_type n, octet_iterator end)
    {
        for (distance_type i = 0; i < n; ++i)
            next(it, end);
    }

    template <typename octet_iterator>
    typename std::iterator_traits<octet_iterator>::difference_type
    distance (octet_iterator first, octet_iterator last)
    {
        typename std::iterator_traits<octet_iterator>::difference_type dist;
        for (dist = 0; first < last; ++dist)
            next(first, last);
        return dist;
    }

    template <typename u16bit_iterator, typename octet_iterator>
    octet_iterator utf16to8 (u16bit_iterator start, u16bit_iterator end, octet_iterator result)
    {
        while (start != end) {
            uint32_t cp = internal::mask16(*start++);
            // Take care of surrogate pairs first
            if (internal::is_surrogate(cp)) {
                if (start != end) {
                    uint32_t trail_surrogate = internal::mask16(*start++);
                    if (trail_surrogate >= internal::TRAIL_SURROGATE_MIN && trail_surrogate <= internal::TRAIL_SURROGATE_MAX)
                        cp = (cp << 10) + trail_surrogate + internal::SURROGATE_OFFSET;
                    else
                        throw invalid_utf16(static_cast<uint16_t>(trail_surrogate));
                }
                else
                    throw invalid_utf16(static_cast<uint16_t>(*start));

            }
            result = append(cp, result);
        }
        return result;
    }

    template <typename u16bit_iterator, typename octet_iterator>
    u16bit_iterator utf8to16 (octet_iterator start, octet_iterator end, u16bit_iterator result)
    {
        while (start != end) {
            uint32_t cp = next(start, end);
            if (cp > 0xffff) { //make a surrogate pair
                *result++ = static_cast<uint16_t>((cp >> 10)   + internal::LEAD_OFFSET);
                *result++ = static_cast<uint16_t>((cp & 0x3ff) + internal::TRAIL_SURROGATE_MIN);
            }
            else
                *result++ = static_cast<uint16_t>(cp);
        }
        return result;
    }

    template <typename octet_iterator, typename u32bit_iterator>
    octet_iterator utf32to8 (u32bit_iterator start, u32bit_iterator end, octet_iterator result)
    {
        while (start != end)
            result = append(*(start++), result);

        return result;
    }

    template <typename octet_iterator, typename u32bit_iterator>
    u32bit_iterator utf8to32 (octet_iterator start, octet_iterator end, u32bit_iterator result)
    {
        while (start < end)
            (*result++) = next(start, end);

        return result;
    }

    // The iterator class
    template <typename octet_iterator>
    class iterator : public std::iterator <std::bidirectional_iterator_tag, uint32_t> {
      octet_iterator it;
      octet_iterator range_start;
      octet_iterator range_end;
      public:
      iterator () {};
      explicit iterator (const octet_iterator& octet_it,
                         const octet_iterator& range_start,
                         const octet_iterator& range_end) :
               it(octet_it), range_start(range_start), range_end(range_end)
      {
          if (it < range_start || it > range_end)
              throw std::out_of_range("Invalid utf-8 iterator position");
      }
      // the default "big three" are OK
      octet_iterator base () const { return it; }
      uint32_t operator * () const
      {
          octet_iterator temp = it;
          return next(temp, range_end);
      }
      bool operator == (const iterator& rhs) const
      {
          if (range_start != rhs.range_start || range_end != rhs.range_end)
              throw std::logic_error("Comparing utf-8 iterators defined with different ranges");
          return (it == rhs.it);
      }
      bool operator != (const iterator& rhs) const
      {
          return !(operator == (rhs));
      }
      iterator& operator ++ ()
      {
          next(it, range_end);
          return *this;
      }
      iterator operator ++ (int)
      {
          iterator temp = *this;
          next(it, range_end);
          return temp;
      }
      iterator& operator -- ()
      {
          prior(it, range_start);
          return *this;
      }
      iterator operator -- (int)
      {
          iterator temp = *this;
          prior(it, range_start);
          return temp;
      }
    }; // class iterator

} // namespace utf8

#endif //header guard


